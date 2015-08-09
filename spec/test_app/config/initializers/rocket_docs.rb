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

RocketDocs.config do |docs|
  docs.title = 'Initializer test'
  docs.description = description
  docs.always_display_description = true
end
