module RuboCop
  module Cop
    module G2
      class BanDecorators < RuboCop::Cop::Cop
        MSG = 'Please avoid creating new Draper decorators or extending existing decorators.'.freeze

        DECORATOR_CLASSES = %w(Draper::Decorator).freeze

        def on_class(node)
          parent_class = full_class_name(node)
          add_offense(node, location: :expression) if DECORATOR_CLASSES.include?(parent_class)
        end

        private

        def full_class_name(node)
          parent_class = node.parent_class
          return if parent_class.nil?

          modules = [parent_class.children[1].to_s]
          parent_class.each_descendant do |desc|
            modules << desc.children[1].to_s
          end
          modules.reverse.join('::')
        end
      end
    end
  end
end
