module TdAgent
  # A set of helper methods for the td-agent cookbook
  module Helpers
    def self.params_to_text(parameters)
      body = ''
      parameters.each do |param_key, param_value|
        if param_value.is_a?(Hash)
          body += "<#{param_key}>\n"
          body += params_to_text(param_value)
          body += "</#{param_key}>\n"
        elsif param_value.is_a?(Array)
          body += if param_value.all? { |array_value| array_value.is_a?(Hash) }
                    param_value.map do |array_value|
                      "<#{param_key}>\n#{params_to_text(array_value)}</#{param_key}>\n"
                    end.join
                  else
                    "#{param_key} [#{param_value.map { |array_value| array_value.to_s.dump }.join(', ')}]\n"
                  end
        else
          body += "#{param_key} #{param_value}\n"
        end
      end
      indent = '  '
      body.each_line.map { |line| "#{indent}#{line}" }.join
    end
  end
end
