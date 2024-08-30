function max_a = max_A(A)
%MAX_A 이 함수의 요약 설명 위치
%   자세한 설명 위치
[n,m] = size(A);

max_a = A(1,1);

if n > 1
    for i = 2:n
        if max_a < A(i,i)
            max_a = A(i,i);
        end
    end

end

end

