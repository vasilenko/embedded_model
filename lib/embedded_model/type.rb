require 'active_record/connection_adapters/postgresql/oid/json'

module EmbeddedModel
  class Type < ::ActiveRecord::ConnectionAdapters::PostgreSQL::OID::Json
    def initialize(&builder)
      @builder = builder
    end

    def type_cast_from_database(value)
      type_cast(super)
    end

    def type_cast_from_user(value)
      type_cast(value)
    end

    def type_cast_for_database(value)
      super(value.as_json)
    end

    private

    def cast_value(value)
      @builder.call(value)
    end
  end
end
