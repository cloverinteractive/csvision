class User < ActiveRecord::Base
  add_csvision :csv_headers => %w/street_cred nickname incognito/, :body => lambda { |u| [ u.street_cred, u.nickname, u.incognito ] }

  scope :flunky, where( 'points <= 5' )

  def incognito
    nickname.reverse
  end

  def street_cred
    points * 100 + ( nickname_cred )
  end

  private
  def nickname_cred
    nickname.unpack( 'U' * nickname.length ).sum # good nickname equals more street cred
  end
end
