module RuboCop
  module Cop
    module G2
      class AggregatesModelBoundary < RuboCop::Cop::Cop
        MSG = 'Do not directly reference an aggregate model outside of the aggregates engine. You should do all CRUD'\
              ' operations through new or existing service objects in the engine.'.freeze

        AGGREGATE_MODELS = %w(
          :AnswerAggregateValue
          :AnswerAggregateDistribution
          :ReportQuarterAnswerAggregateValue
          :ReportQuarterAnswerAggregateDistribution
          :HighestRatedAnswerAggregate
          :HighestRatedAnswerAggregateDistribution
        ).freeze

        AGGREGATES_ENGINE_PATH = 'engines/aggregates'.freeze
        SPEC_PATH = 'spec'.freeze

        def_node_matcher :direct_model_reference?, <<~PATTERN
          (const (const _ :Aggregates) {#{AGGREGATE_MODELS.join(' ')}})
        PATTERN

        def on_const(node)
          return if ignored_file?
          add_offense(node, location: :expression) if direct_model_reference?(node)
        end

        private

        def ignored_file?
          file_path = processed_source.path || ''
          file_path.include?(AGGREGATES_ENGINE_PATH) || file_path.include?(SPEC_PATH)
        end
      end
    end
  end
end
