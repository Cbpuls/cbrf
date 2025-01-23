# frozen_string_literal: true

require "forwardable"

module Cbrf
  class CreditOrganization
    extend Forwardable

    def initialize(id)
      @id = Id.new(id)
    end

    def_delegators :@id, :bic, :internal_code, :registry_number

    def info
      Api.call(:CreditInfoByIntCode, { InternalCode: internal_code }).to_h
    end

    def note
      Api.call(:CreditInfoByRegCodeShort, { CredorgNumber: registry_number }).to_h
    end

    def form(type)
      Form.new(type, registry_number)
    end

    class << self
      def last_update
        DateTime.xmlschema Api.call(:LastUpdate).value
      end

      def bics
        Api.call(:EnumBIC).to_h
      end

      def licenses
        Api.call(:EnumLicenses).to_h
      end

      def info(*codes)
        Api.call(:CreditInfoByIntCodeEx, { InternalCodes: codes }).to_h
      end
    end
  end
end
