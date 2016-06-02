module EmbeddedModel
  class Type < ActiveRecord::Type::Internal::AbstractJson
    def initialize(&builder)
      @builder = builder
    end

    def cast(attrs)
      @builder.call(attrs)
    end

    def serialize(obj)
      super(obj.as_json)
    end

    def deserialize(json)
      cast(super)
    end
  end
end
