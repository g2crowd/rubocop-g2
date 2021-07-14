require 'spec_helper'

RSpec.describe RuboCop::Cop::G2::AccessibleIcons do
  subject(:cop) { described_class.new }

  it 'registers an offense when keyword arguments include neither aria_label nor decorative' do
    expect_offense(<<~RUBY)
      inline_icon 'test'
      ^^^^^^^^^^^^^^^^^^ Make SVGs accessible by either marking them as decorative (`decorative: true`) or adding a label (`aria_label: t('path.to.description')`)
    RUBY
  end

  it 'registers an offense when keyword arguments include both `decorative: true` and :aria_label' do
    expect_offense(<<~RUBY)
      inline_icon 'test', decorative: true, aria_label: 'a label', another_kwarg: :value
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Make SVGs accessible by either marking them as decorative (`decorative: true`) or adding a label (`aria_label: t('path.to.description')`)
    RUBY
  end

  it 'registers an offense when keyword arguments include `aria_label: nil`' do
    expect_offense(<<~RUBY)
      inline_icon 'test', aria_label: nil
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Make SVGs accessible by either marking them as decorative (`decorative: true`) or adding a label (`aria_label: t('path.to.description')`)
    RUBY
  end

  it 'does not register an offense when keyword arguments include :aria_label with a non-nil value' do
    expect_no_offenses(<<~RUBY)
      inline_icon 'test', aria_label: 'a label'
    RUBY
  end

  it 'does not register an offense when keyword arguments include `decorative: true`' do
    expect_no_offenses(<<~RUBY)
      inline_icon 'test', decorative: true
    RUBY
  end
end
