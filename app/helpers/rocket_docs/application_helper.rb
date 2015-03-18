module RocketDocs
  module ApplicationHelper
    def doc_id(doc)
      "version_#{web_safe(doc.version)}"
    end

    def controller_id(controller)
      "#{doc_id(controller.documentation)}_controller_"\
      "#{web_safe(controller.name)}"
    end

    def action_id(action)
      "#{controller_id(action.controller)}_action_#{web_safe(action.name)}"
    end

    def method_id(action, method)
      "#{action_id(action)}_method_#{web_safe(method)}"
    end

    def web_safe(string)
      string.to_s.humanize.gsub(/\s/, '').underscore
    end
  end
end
