module RuboCop
  module Cop
    module G2
      class PredicateMemoization < RuboCop::Cop::Cop
        MSG = 'Do not use `@foo ||= bar` to memoize predicate methods, since `false` or `nil` return values will not'\
              ' be memoized with this approach.'.freeze

        def on_def(node)
          return unless predicate_method?(node)

          offending_nodes(node).each do |offender|
            add_offense(offender, location: :expression)
          end
        end

        private

        def predicate_method?(node)
          node.method_name.to_s.end_with?('?')
        end

        def offending_nodes(node)
          node.each_descendant(:or_asgn).select do |or_assignment|
            instance_var_assignment?(or_assignment)
          end
        end

        def instance_var_assignment?(assignment)
          assignment.children.first.type == :ivasgn
        end
      end
    end
  end
end
