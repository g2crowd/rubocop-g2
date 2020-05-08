require 'spec_helper'

RSpec.describe RuboCop::Cop::G2::BanDecorators do
  subject(:cop) { described_class.new }

  it 'registers an offense for classes that inherit from Draper::Decorator' do
    expect_offense(<<~RUBY)
      class Foo < Draper::Decorator
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Please avoid creating new Draper decorators or extending existing decorators.
      end
    RUBY
  end

  it 'does not register an offense for an arbitrary class called Decorator' do
    expect_no_offenses(<<~RUBY)
      class Foo < Decorator; end
    RUBY
  end

  it 'does not register an offense for an appearance of Draper::Decorator if no class inherits it' do
    expect_no_offenses(<<~RUBY)
      Draper::Decorator.object_class?
    RUBY
  end
end
