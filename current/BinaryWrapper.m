classdef BinaryWrapper < handle
	
	properties
		data logical
	end

	methods
		function BinaryWrapper = BinaryWrapper(data)
			BinaryWrapper.data = data;
		end

		function [] = setData(BinaryWrapper,r,c,in)
			BinaryWrapper.data(r,c) = in;
		end

		function out = getData(BinaryWrapper,r,c)
			if r < 1 || r > size(BinaryWrapper.data,1) || c < 1 || c > size(BinaryWrapper.data,2)
				out = false;
			else
				out = BinaryWrapper.data(r,c);
			end
		end
	end

end