require 'spec_helper'

RSpec.describe RuboCop::Cop::G2::AggregatesModelBoundary do
  subject(:cop) { described_class.new }

  # rubocop:disable RSpec/ExampleLength
  it 'registers an offense for classes that inherit from Draper::Decorator' do
    expect_offense(<<~RUBY)
      def some_method
        Aggregates::AnswerAggregateValue.where(product_ids: ids).delete_all
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not directly reference an aggregate model outside of the aggregates engine. You should do all CRUD operations through new or existing service objects in the engine.
      end
    RUBY
  end
  # rubocop:enable RSpec/ExampleLength

  it 'does not register an offense for arbitrary classes in aggregates engine' do
    expect_no_offenses(<<~RUBY)
      def some_method
        Aggregates::DeleteAnswerAggregateValues.run!(product_ids: ids)
      end
    RUBY
  end
end
