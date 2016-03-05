require 'active_record'

require 'embedded_model/version'
require 'embedded_model/type'
require 'embedded_model/embedder'
require 'embedded_model/active_record_extension'

ActiveRecord::Base.include(EmbeddedModel::ActiveRecordExtension)
