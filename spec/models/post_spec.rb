require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'testing article model' do
    subject { described_class.new(title: 'Test') }

    it 'valid article attributes' do
      expect(subject).to be_valid
    end

    it 'Must have a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'Must have a title with minimum length' do
      subject.title = ''
      expect(subject).to_not be_valid
    end

    it 'Must not have a title with maximum length' do
      subject.title = 'A' * 101
      expect(subject).to_not be_valid
    end
  end
end