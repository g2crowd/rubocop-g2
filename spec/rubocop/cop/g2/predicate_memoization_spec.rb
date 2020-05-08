require 'spec_helper'

# rubocop:disable RSpec/ExampleLength
RSpec.describe RuboCop::Cop::G2::PredicateMemoization do
  subject(:cop) { described_class.new }

  it 'does not register an offense for non-predicate memoization with a boolean' do
    expect_no_offenses(<<~RUBY)
      class Foo
        def bar
          @baz ||= true
        end
      end
    RUBY
  end

  it 'does not register an offense for assignment' do
    expect_no_offenses(<<~RUBY)
      class Foo
        def bar?
          @baz = true
        end
      end
    RUBY
  end

  it 'registers an offense for predicate memoization' do
    expect_offense(<<~RUBY)
      class Foo
        def bar?
          @baz ||= true
          ^^^^^^^^^^^^^ Do not use `@foo ||= bar` to memoize predicate methods, since `false` or `nil` return values will not be memoized with this approach.
        end
      end
    RUBY
  end

  it 'registers an offense for predicate memoization after local var assignment' do
    expect_offense(<<~RUBY)
      class Foo
        def bar?
          baz = true
          @bar ||= baz
          ^^^^^^^^^^^^ Do not use `@foo ||= bar` to memoize predicate methods, since `false` or `nil` return values will not be memoized with this approach.
        end
      end
    RUBY
  end
end
# rubocop:enable RSpec/ExampleLength
