require 'rails_helper'

description = <<-EOF
Lorem ipsum dolor sit amet, consectetur adipiscing elit.
Duis pulvinar elit ut lacus lacinia, a maximus ex gravida.
Aliquam sodales, mauris et aliquam hendrerit, odio erat aliquam lectus, luctus
mollis justo ipsum vitae lectus. Duis blandit, nulla et fermentum hendrerit,
orci nulla elementum tellus, et pellentesque orci velit eget dolor.

Nulla facilisi. Aliquam convallis id ipsum dictum malesuada.
Etiam ac nulla auctor, rhoncus metus at, condimentum nibh. Cras sit amet nulla
bibendum, mattis sem vulputate, convallis lacus. Pellentesque id tortor mauris.
Integer placerat pulvinar mauris ut condimentum. Mauris sodales mattis tortor
ac placerat. Mauris vitae libero a erat blandit iaculis. Mauris egestas massa eu
augue laoreet vulputate.
EOF

RSpec.describe RocketDocs do
  describe '#config' do
    url = '/test/url'
    title = 'Config test'

    RocketDocs.config do |docs|
      docs.url = url
      docs.title = title
      docs.description = description
    end

    it 'saves a configuration' do
      expect(RocketDocs.url).to eq(url)
      expect(RocketDocs.title).to eq(title)
      expect(RocketDocs.description).to eq(description)
    end
  end

  describe '#format_string' do
    input_string = "This\nis\n\na\n\n\ntest\n"
    output_string = 'This<br>is<br><br>a<br><br><br>test<br>'

    it 'formats a regural string to HTML' do
      expect(RocketDocs.format_string(input_string)).to eq(output_string)
    end
  end
end
