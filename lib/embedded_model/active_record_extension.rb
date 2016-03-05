module EmbeddedModel
  module ActiveRecordExtension
    extend ActiveSupport::Concern

    class_methods do
      def embeds_one(column, options = {})
        EmbeddedModel::Embedder.new(self, column, options).embed_object
      end

      def embeds_many(column, options = {})
        EmbeddedModel::Embedder.new(self, column, options).embed_collection
      end
    end
  end
end
