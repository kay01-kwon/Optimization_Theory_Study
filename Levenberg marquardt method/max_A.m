function max_a = max_A(A)
%MAX_A 이 함수의 요약 설명 위치
%   자세한 설명 위치
[n,~] = size(A);

max_a = A(1,1);

for i = 2:n
    if A(i,i) > max_a
        max_a = A(i,i);
    else
    end
end

end

