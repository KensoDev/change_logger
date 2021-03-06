require 'rails'

module ChangeLogger
  require 'change_logger/railtie' if defined?(Rails)

  module ActiveRecordExtensions
    extend ActiveSupport::Concern

    included do
      after_create do
        ChangeLogger::LogManager.audit_model({ record: self, action: 'create' })
      end
      after_update do
        ChangeLogger::LogManager.audit_model( {record: self, action: 'update' })
      end
      after_destroy do
        ChangeLogger::LogManager.audit_model({ record: self, action: 'destroy' })
      end
    end
  end
end
