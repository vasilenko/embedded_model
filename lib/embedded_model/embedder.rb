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
      ->(attrs) { attrs.is_a?(model) ? attrs : model.new(attrs) }
    end

    def collection_builder
      ->(arr) { arr.map(&object_builder) }
    end
  end
end
