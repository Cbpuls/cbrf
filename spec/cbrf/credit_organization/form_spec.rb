# frozen_string_literal: true

RSpec.describe Cbrf::CreditOrganization::Form, with_banks: true do
  let(:type) { self.class.description }
  let(:registry_number) { sber.registry_number }
  let(:date) { Date.new 2024, 1, 1 }
  let(:indicator) { nil }

  subject { described_class.new(type, registry_number) }

  let(:data) { subject.on date }
  let(:dates) { subject.dates }
  let(:max) { subject.max }
  let(:indicators) { subject.indicators }

  shared_examples "a form" do
    context "data on 2024-01-01" do
      it { expect(subject.on(Date.new(2024, 1, 1))).not_to be_empty }
    end

    context "available dates" do
      it { expect(subject.dates).not_to be_empty }
    end

    context "max date" do
      it { expect(subject.max).to be_a DateTime }
    end
  end

  let(:revenue) { subject.by(indicator, from:, to:) }

  describe "101" do
    it_behaves_like "a form" do
      let(:type) { 101 }
      let(:indicator) { 106 }

      context "data by indicator from 2024-01-01 to 2024-01-01" do
        it { expect(subject.by(indicator, from: Date.new(2024, 1, 1), to: Date.new(2024, 2, 1))).not_to be_empty }
      end

      context "indicators" do
        it { expect(subject.indicators).not_to be_empty }
      end
    end
  end

  describe "102" do
    it_behaves_like "a form" do
      let(:type) { 102 }
      let(:indicator) { 11_000 }

      context "data by indicator from 2024-01-01 to 2024-01-01" do
        it { expect(subject.by(indicator, from: Date.new(2024, 1, 1), to: Date.new(2024, 2, 1))).not_to be_empty }
      end

      context "indicators" do
        it { expect(subject.indicators).not_to be_empty }
      end
    end
  end

  describe "123" do
    it_behaves_like "a form" do
      let(:type) { 123 }
    end
  end

  describe "134" do
    let(:type) { 134 }
    it "should return data on 2015-01-01" do
      expect(subject.on(Date.new(2015, 1, 1))).not_to be_empty
    end
    it "should return dates" do
      expect(subject.dates).not_to be_empty
    end
  end
  describe "135" do
    let(:type) { 135 }

    it "should return data on 2024-01-01" do
      expect(subject.on(Date.new(2024, 1, 1))).not_to be_empty
    end

    it "should return meta data on 2024-01-01" do
      expect(subject.meta(Date.new(2024, 1, 1))).not_to be_empty
    end

    it "should return dates" do
      expect(subject.dates).not_to be_empty
    end
  end

  describe "802" do
    let(:type) { 802 }

    it "should return nil on 2024-01-01" do
      expect(data).to be_nil
    end
  end

  describe "803" do
    let(:type) { 803 }
    it "should return nil on 2024-01-01" do
      expect(data).to be_nil
    end
  end

  describe "805" do
    pending "Not implemented"
  end

  describe "806" do
    let(:type) { 806 }
    it "should return data on 2024-01-01" do
      expect(data).not_to be_empty
    end
  end

  describe "807" do
  end

  describe "808" do
  end

  describe "810" do
    it "should return data on 2024-01-01" do
      expect(data.dig(:NewDataSet, :F810)).not_to be_empty
    end
  end

  describe "813" do
  end

  describe "814" do
    it "should return data on 2024-01-01" do
      expect(data.dig(:NewDataSet, :F814)).not_to be_empty
    end
  end
end
