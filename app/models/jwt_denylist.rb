class JwtDenylist < ApplicationRecord
    include Devise::JWT::RevocationStrategies::Denylist
    belongs_to :user

    self.table_name = 'jwt_denylist'
end
