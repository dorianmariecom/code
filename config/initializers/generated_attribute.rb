module Rails
  module Generators
    class GeneratedAttribute
      def attr_options_to_s
        if attr_options.empty?
          ""
        elsif attr_options[:size]
          "{#{attr_options[:size]}}"
        elsif attr_options[:limit]
          "{#{attr_options[:limit]}}"
        elsif attr_options[:precision] && attr_options[:scale]
          "{#{attr_options[:precision]},#{attr_options[:scale]}}"
        else
          "{#{attr_options.keys.join(",")}}"
        end
      end

      def to_s
        if has_uniq_index?
          "#{name}:#{type}#{attr_options_to_s}:uniq"
        elsif has_index?
          "#{name}:#{type}#{attr_options_to_s}:index"
        else
          "#{name}:#{type}#{attr_options_to_s}"
        end
      end
    end
  end
end
