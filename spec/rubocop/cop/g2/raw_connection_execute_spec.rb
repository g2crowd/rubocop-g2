require 'spec_helper'

RSpec.describe RuboCop::Cop::G2::RawConnectionExecute do
  subject(:cop) { described_class.new }

  it 'registers an offense for calls to ActiveModel::Base.connection.execute' do
    expect_offense(<<~RUBY)
      ApplicationRecord.connection.execute(raw_sql)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The result returned by this statement is manually memory managed. Please use one of the exec_query/exec_update/exec_insert/exec_delete wrappers instead.
    RUBY
  end

  it 'does not register an offense for calling execute on arbitrary class' do
    expect_no_offenses(<<~RUBY)
      SomeClass.execute('arbitary arguments')
    RUBY
  end
end
