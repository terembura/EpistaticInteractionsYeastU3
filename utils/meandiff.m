function meandiff(reg_data, lam_data, lam_median, fname)
%
%
%
%
%

% try to find the corresponding 
if isfield(reg_data,'ystd'),
    lam_mean = reg_data.y;
    lam_std  = reg_data.ystd;    
else
    if ~isempty(setdiff(reg_data.rownames, lam_data.rownames)),
        error('meandiff: inconsistency in the input data the reg_data.rownames should a subset of lam_data.rownames');
    end

    [rownames_joint, Isnp, Ilam] = intersect(reg_data.rownames, lam_data.rownames);
    lam_mean = lam_data.lam_mean(Ilam) - lam_median;
    lam_std  = lam_data.lam_std(Ilam);
end


% single mutations
Im1 = sum(reg_data.X1,2)==1; 
for j = 1:size(reg_data.X1,2)
    Isingle{j} = find((reg_data.X1(:,j)==1) & Im1);
end
Im1 = find(Im1);


% double mutations - ignore all the pairs where Isingle is empty
Im2           = find(sum(reg_data.X1,2)==2);
Isingle_empty = find(cellfun(@isempty, Isingle));
Im2_ok        = zeros(size(Im2));
for k = 1:length(Im2)
    % getting the indices
    dd = find(reg_data.X1(Im2(k),:));
    i  = dd(1);
    j  = dd(2);
    
%    dada(k,1) = i;
%    dada(k,2) = j;
    
    if ~ismember(i, Isingle_empty) & ~ismember(j, Isingle_empty)   
        Im2_ok(k) = 1;
    end
end
Im2      = Im2(find(Im2_ok));
rownames = reg_data.rownames(Im2);

% find mean and empirical variance of the sigle mutations
for i = 1:length(Isingle)
    if ~isempty(Isingle{i})
        m(i) = mean(lam_mean(Isingle{i}));
        v(i) = std(lam_mean(Isingle{i}))^2;
    end
    % nn(i) = length(Isingle{i});
    % v(i)  = sum(data.lam_std(data.Isingle{i}).^2)/nn(i);    
end

idx     = zeros(length(Im2),2);
mm      = zeros(length(Im2),2);
mij     = zeros(length(Im2),1);
vij     = zeros(length(Im2),1);
z_score = zeros(length(Im2),1);

% find mean and average variance of the double mutations, compute diffs and z-scores
for k = 1:length(Im2)
    % getting the indices
    dd = find(reg_data.X1(Im2(k),:));
    i = dd(1);
    j = dd(2);
    
    idx(k,1) = i;
    idx(k,2) = j;
        
    % find all barcodes with the same pattern
    K = find(reg_data.X1(Im2,:)*reg_data.X1(Im2(k),:)'==2);
    
    % disp([k, length(K)]);
    
    mij(k) = sum(lam_mean(Im2(K)))/length(K);
    vij(k) = sum(lam_std(Im2(K)).^2)/length(K);
    
    mm(k,:) = [m(i), m(j)];
    
    mdiff(k)  = mij(k) - (m(i) + m(j));
%    mdiffx(k) = mij(k) - (mm(k,1) + mm(k,2));
    
    z_score(k) = (mij(k) - (m(i) + m(j)))/sqrt(vij(k) + v(i) + v(j));
end         

wtf   = sparse(reg_data.diagn(1,:)', reg_data.diagn(2,:)', [1:size(reg_data.diagn,2)]');
for j = 1:size(mm,1)
    idxl1(j) = wtf(idx(j,1), idx(j,2));
end
z_l1  = reg_data.zopt(idxl1);

if ~isempty(fname)
    writetable(fname, [idx(:,1), idx(:,2), lam_mean(Im2), mm(:,1), mm(:,2), mij, mij - (mm(:,1) + mm(:,2)), z_score, z_l1],... 
        rownames, {'barcode', 'mut_1', 'mut_2', 'lambda_value', 'avg_single_mut_lambda_1', 'avg_single_mut_lambda_2',...
        'avg_double_mut_lambda', 'lambda_diff', 'z_score', 'z_l1' } );
end

% other data analysys,

for k = 1:length(mdiff)
    tt{k} = strcat('(',num2str(idx(k,1)),',',num2str(idx(k,2)),')');
end

figure;
    hist(lam_mean(Im2),50);
    xlabel('\lambda of double mutations');
    title('The mean valued of lambda for the double mutations (no averaging over bacodes)');
    
figure;
    hist(mij,50);
    xlabel('\lambda of double mutations averaged over bacodes');
    title('The mean valued of lambda for the double mutations averaged over bacodes');


figure;
    plot(mdiff, z_score,'.');
    text(mdiff, z_score, tt);
    xlabel('\lambda_{diff}');
    ylabel('z-score');
    title('The \lambda_{diff} vs. z-score');
    

figure;
    plot(mdiff, z_l1,'.');
    text(mdiff, z_l1, tt);
    xlabel('\lambda_{diff}');
    ylabel('Regression coefficient');
    title('The \lambda_{diff} vs. regression coefficient');    

I = find(abs(z_l1)>1e-2);
figure;
    plot(mdiff(I), z_l1(I),'.');
    text(mdiff(I), z_l1(I), tt(I));
    xlabel('\lambda_{diff}');
    ylabel('Regression coefficient');
    title('The \lambda_{diff} vs. regression coefficient'); 

    
% keyboard;             