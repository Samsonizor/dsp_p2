function [ out ] = quantize( x,b )
    out = 2^(-b)*round(x*2^b);
end

