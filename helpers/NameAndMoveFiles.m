%% Name and Move song files 
TargetDir = '/Users/yardenc/Documents/Experiments/Audio analysis/CanaryData';

BaseDir = '/Volumes/stone_age/canary_syntax_data/CLEAN/Liz/';

cd(BaseDir);
d=dir; d=d([d.isdir]);
BirdsDirs = {d(3:end).name};
n_birds = numel(BirdsDirs);
%%
for birdnum = 1:n_birds
    file_cnt = 1;
    cd(TargetDir);
    birdname = BirdsDirs{birdnum};
    if ~exist(birdname,'dir');
        mkdir(birdname);
    end
    cd(BaseDir);
    cd(BirdsDirs{birdnum});
    d=dir; d={d.name};
    d=d{cellfun(@(z)ismember('&',z),d)};
    
    
    BOUTstat = fullfile(BaseDir,BirdsDirs{birdnum},d,'stats',[d '.mat']);
    load(BOUTstat);
    tokens = regexp(BOUT{bout_cnt}.filenames{1},'/','split');
    dirname = 'start'; %tokens{1};
    syl_str = [];
    for bout_cnt = 1:numel(BOUT)
        syl_str = [syl_str BOUT{bout_cnt}.string];
        tokens = regexp(BOUT{bout_cnt}.filenames{1},'/','split');
        if ~strcmp(tokens{1},dirname)
            dirname = tokens{1};
            source_file = fullfile(BaseDir,BirdsDirs{birdnum},d,dirname,'canary_singing.wav');
            target_file = fullfile(TargetDir,birdname,[birdname '_' sprintf('%04d',file_cnt) '_' datestr(BOUT{bout_cnt}.datenum,'yyyy_mm_dd') '.wav']);
            file_cnt = file_cnt + 1;
            copyfile(source_file,target_file);
        end
        
    cd(BaseDir);