older(masha, misha). % Маша старше Миши

% Это правило
older(X,Y) :- older(X, Z), older(Z,Y).