namespace :interdasting do
  desc 'Generates static documentation files'
  variables = [:input_files, :output_folder, :version_name]
  task :generate, variables => :environment  do |_task, args|
    # Input sanitization
    # TODO: Potential bug with pathnames containing spaces
    input = args[:input_files] && args[:input_files].split.presence
    output = args[:output_folder].presence ||
             Rails.root.join('public', 'system', 'documentation').to_s
    version = args[:version_name].presence || 'Unknown'

    # Generate documentation
    doc = Interdasting.documentation_for_files(input, version)

    # Prepare input and output files
    template_folder = File.expand_path(
                    '../../../app/views',
                    __FILE__)
    template_path = template_folder + '/docs/interdasting/show.slim'
    layout_path = template_folder + '/layouts/interdasting/application.slim'

    FileUtils.mkdir_p(output)
    output = output[-1] == '/' ? output : output << '/'
    output << "#{version}.html"

    # Render HTML
    lookup_context = ActionView::LookupContext.new(template_folder)
    view_builder = ActionView::Base.new(lookup_context)
    view_builder.extend ActionView::Helpers
    view_builder.extend Interdasting::ApplicationHelper
    layout = Slim::Template.new { File.open(layout_path, 'r').read }
    view = Slim::Template.new { File.open(template_path, 'r').read }
    html = layout.render(view_builder, doc: doc) do
      view.render(view_builder, doc: doc)
    end
    File.open(output, 'w+') do |file|
      file.puts(html)
    end
  end
end
