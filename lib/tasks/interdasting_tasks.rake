namespace :rocket_docs do
  desc 'Generates static HTML documentation files'
  generator_args = [:version_name, :input_files, :output_folder]
  task :generate, generator_args => :environment  do |_task, args|
    version, input, output = sanitize_generator_input(args)
    fail('A version name has to be provided') unless version
    fail('At leas one input file has to be provided') unless input

    doc = RocketDocs.documentation_for_files(input, version)

    template_folder = generator_template_folder
    layout_path = template_folder + '/layouts/rocket_docs/application.slim'
    template_path = template_folder + '/docs/rocket_docs/show.slim'

    prepare_generator_output(output, version, 'html')

    view_builder = generator_view_builder(template_folder)
    view_builder.instance_variable_set(:@doc, doc)
    layout = Slim::Template.new { File.open(layout_path, 'r').read }
    view = Slim::Template.new { File.open(template_path, 'r').read }
    html = layout.render(view_builder) do
      view.render(view_builder).html_safe
    end
    File.open(output, 'w+') do |file|
      file.puts(html)
    end
  end
  task :gen, generator_args => :generate

  desc 'Generates static MARKDOWN documentation files'
  md_generator_args = generator_args
  task :generate_markdown, md_generator_args => :environment  do |_task, args|
    version, input, output = sanitize_generator_input(args)

    doc = RocketDocs.documentation_for_files(input, version)

    template_folder = generator_template_folder
    template_path = template_folder + '/docs/rocket_docs/show.markdown.erb'

    prepare_generator_output(output, version, 'markdown')

    view_builder = generator_view_builder(template_folder)
    view_builder.instance_variable_set(:@doc, doc)
    view = ERB.new(File.open(template_path, 'r').read)
    html = view.result(view_builder.instance_eval { binding })
    File.open(output, 'w+') do |file|
      file.puts(html)
    end
  end
  task :generate_md, md_generator_args => :generate_markdown
  task :gen_md, md_generator_args => :generate_markdown

  ###############
  ### HELPERS ###
  ###############

  def sanitize_generator_input(args)
    version = args[:version_name].presence
    # TODO: Potential bug with pathnames containing spaces
    input = args[:input_files] && args[:input_files].split.presence
    output = args[:output_folder].presence ||
             Rails.root.join('public', 'system', 'documentation').to_s
    fail('A version name has to be provided') unless version
    fail('At leas one input file has to be provided') unless input
    [version, input, output]
  end

  def generator_template_folder
    File.expand_path('../../../app/views', __FILE__)
  end

  def prepare_generator_output(output, name, ext)
    FileUtils.mkdir_p(output)
    output = output[-1] == '/' ? output : output << '/'
    output << "#{name}.#{ext}"
  end

  def generator_view_builder(template_folder)
    lookup_context = ActionView::LookupContext.new(template_folder)
    view_builder = ActionView::Base.new(lookup_context)
    view_builder.extend ActionView::Helpers
    view_builder.extend RocketDocs::ApplicationHelper
    view_builder
  end
end
