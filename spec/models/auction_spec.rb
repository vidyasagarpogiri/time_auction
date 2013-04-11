require 'spec_helper'

describe Auction do
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
  it { should validate_presence_of(:end_date)}
  it { should validate_presence_of(:category_id)}
  it { should validate_presence_of(:deadline)}

  
end