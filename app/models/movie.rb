class Movie < ActiveRecord::Base

def self.getRatingsList
   rating = self.select(:rating).uniq
   uniqRating = Array.new
   rating.each do |rt|
   uniqRating.push(rt.rating)
   end
   return uniqRating.uniq
end

end
