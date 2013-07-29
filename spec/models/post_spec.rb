require 'spec_helper'

describe Post do
  it { should respond_to :game }
  it { should respond_to :params }
end
