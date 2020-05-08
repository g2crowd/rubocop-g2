module RuboCop
  module Cop
    module G2
      class RawConnectionExecute < RuboCop::Cop::Cop
        MSG = 'The result returned by this statement is manually memory managed. Please use one of the'\
              ' exec_query/exec_update/exec_insert/exec_delete wrappers instead.'.freeze

        def_node_matcher :raw_connection_execute?, <<~PATTERN
          (send (send _ :connection) :execute _)
        PATTERN

        def on_send(node)
          return unless raw_connection_execute?(node)
          add_offense(node)
        end
      end
    end
  end
end
