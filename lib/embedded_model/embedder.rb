module EmbeddedModel
  class Embedder
    def initialize(container, column, options = {})
      @container = container
      @column = column
      @class_name = options[:class_name]
    end

    def embed_object
      embed object_builder
    end

    def embed_collection
      embed collection_builder, default: []
    end

    private

    def embed(builder, options = {})
      @container.attribute(@column, EmbeddedModel::Type.new(&builder), options)
    end

    def model
      @model ||=
        begin
          return @class_name if @class_name.is_a?(Class)
          (@class_name || @column).to_s.classify.constantize
        end
    end

    def object_builder
      ->(object_or_attributes) do
        if object_or_attributes.is_a?(model)
          object_or_attributes
        else
          attributes = object_or_attributes.try(:to_hash)
          model.new(attributes) if attributes
        end
      end
    end

    def collection_builder
      ->(arr) { arr.try(:map, &object_builder) }
    end
  end
end
