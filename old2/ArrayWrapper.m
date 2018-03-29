classdef ArrayWrapper < handle
	
	properties
		data
	end

	methods
		function ArrayWrapper = ArrayWrapper(data)
			ArrayWrapper.data = data;
		end
	end

end