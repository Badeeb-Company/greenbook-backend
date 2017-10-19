class WorkingDay < ApplicationRecord
	belongs_to :shop

	enum state:{
		opened: 'opened',
		closed: 'closed'
	}
	
end
