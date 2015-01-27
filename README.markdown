# About

Interdasting is a automatic documentation generator for APIs.

It is intended to be used with  [rocket_pants](https://github.com/Sutto/rocket_pants) based APIs but it can also be used as a standalone generator through rake tasks.

This project was mostly inspired by the [grape-swagger project](https://github.com/tim-vandecasteele/grape-swagger).

All documentation is done in comments so that your code doesn't get littered with code that has no functional purpose, thus making your code more readable.

Example:
![Before](http://i.imgur.com/sspHnoC.png)
![After](http://i.imgur.com/nPJ4cey.png)

# Installation

Currently, you can only install this gem via GitHub.

```Ruby
# In your Gemfile
gem 'interdasting', github: 'stankec/interdasting'
```

It will be released on [RubyGems](https://rubygems.org/) once better specs have been written and some missing features get implemented.

If you are using [rocket_pants](https://github.com/Sutto/rocket_pants) you only have to mount the engine in your routes file.

```Ruby
# In your config/routes.rb
mount Interdasting::Engine => '/api-doc'
```

The gem also adds two new rake tasks for generating documentation as static html or markdown files

```Ruby
# For HTML files
rake interdasting:generate[version_name, input_files, output_folder]
rake interdasting:gen[version_name, input_files, output_folder]
```

```Ruby
# For MARKDOWN files
rake interdasting:generate_markdown[version_name, input_files, output_folde]
rake interdasting:generate_md[version_name, input_files, output_folde]
rake interdasting:gen_md[version_name, input_files, output_folde]
```

# Configuration

Basically no configuration is needed.
By default every api route from your routes file will be used when generating the documentation.

It's important to note that only methods that are accessible (are used in the routes file) will get documented.

# Usage

If you are using [rocket_pants](https://github.com/Sutto/rocket_pants), after you mount the engine in your routes file the only thing you have to do is write some comments in front of the method you want to document.

__Remeber indentation is important!__


### Keywords

There are a few keywords to help you: `DOC`, `PARAMS`, `GET`, `PUT`, `POST`, `PATCH`, `DELETE`

It doesn't matter if the words are lower or upper case.

`DOC` is used to define documentation, text that describes the action.

Example:
```Ruby
# Doc
#   This action lists all posts
#

def index
  ...
end
```

`PARAMS` is used to define which parameters the action accepts.

```Ruby
# Doc
#   This action displays a single post
#
# Params
#   id: integer (the post's identifier)
#

def show
  ...
end
```

`GET`, `PUT`, `POST`, `PATCH`, `DELETE` are used to define method specifics.

```Ruby
# GET
#   Doc
#     This action returns a users current location
#   Params
#     id: integer (the user's identifier)
# POST
#   Doc
#     This action sets a users location
#   Params
#     id: integer (the user's identifier)
#     lon: float
#     lat: gloat

def user_location
  ...
end
```

For the above example you could also write:

```Ruby
# Doc
#   This action returns a users current location
# Params
#   id: integer (the user's identifier)
#
# POST
#   Doc
#     This action sets a users location
#   Params
#     id: integer (the user's identifier)
#     lon: float
#     lat: gloat

def user_location
  ...
end
```

This would set the `DOC` and `PARAMS` values as default values for all methods except for `POST` which has it's own `DOC` and `PARAMS` values.

### Examples

Currently the best example you can look at is the `test_app` located in the `specs` folder. You can even start the app and experiment a little bit.

### Rake task

The rake tasks accept three arguments. A version name, a list of file paths separated by spaces and an output folder. The output folder is optional, if no output folder is defined then it will default to `route_to_your_rails_app/public/system/documentation`

Example:

```Ruby
rake interdasting:generate['Legacy', 'app/controllers/api/v1/people_controller.rb app/controllers/api/v1/posts_controller.rb','public/system/api-docs']
```
This would generate a `Legacy.html` file in your `public/system/api-docs` folder and you could access it by going to `http://localhost:3000/system/api-docs/Legacy.html`

# Contributing

If you feel like helping, feel free to fork this project and issue a pull request. There are many things that need to be done. Here's jus a few:

1. Specs
2. Ability to make a API call from the GUI
3. Caching

# License

This project rocks and uses MIT-LICENSE.
