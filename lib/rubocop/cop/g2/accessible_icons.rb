module RuboCop
  module Cop
    module G2
      class AccessibleIcons < RuboCop::Cop::Cop
        MSG = 'Make SVGs accessible by either marking them as decorative (`decorative: true`) '\
              "or adding a label (`aria_label: t('path.to.description')`)".freeze

        RESTRICT_ON_SEND = %i(inline_icon).freeze

        def on_send(node)
          keyword_args = array_of_kwargs node.arguments
          return if args_include_decorative?(keyword_args) ^ args_include_aria_label?(keyword_args)

          add_offense node
        end

        private

        def array_of_kwargs(args)
          args.find(&:hash_type?)&.children&.map(&:children) || []
        end

        def args_include_decorative?(args)
          args.include? [s(:sym, :decorative), s(:true)]
        end

        def args_include_aria_label?(args)
          args.any? { |arg| arg.first == s(:sym, :aria_label) && arg.last != s(:nil) }
        end
      end
    end
  end
end
