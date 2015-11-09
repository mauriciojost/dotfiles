function [sample_label, sample_value] = extract(theLine)
  splits = strsplit(theLine, ' ');
  sample_label = strjoin(splits(1));
  sample_value = str2num(strjoin(splits(2)));
endfunction

function build_plot(samples_labels, samples)
  
  plotsize = 800;
  
  times_sec_raw = samples(1,:);
  % times_sec_norm = times_sec_raw - min(times_sec_raw);
  times_sec_norm = times_sec_raw;
  % times_hours_norm = times_sec_norm / 3600;
  times_hours_norm = times_sec_norm;
  figure('Position',[0,0,plotsize*2,plotsize]);
  xlabel('Time [hours]'); ylabel('Values');
  latest_hour = max(times_hours_norm);
  earliest_hour = min(times_hours_norm);
  axis ([earliest_hour, latest_hour, 0, 100]);
  plot(times_hours_norm, samples([2:rows(samples)],:),'.-')
  legend(samples_labels(2:length(samples_labels)))
  grid
endfunction

samples_labels = [{}];
samples = [];

%HOME/.logs/followup.log
fid = fopen(strcat(getenv('HOME'), '/.logs/followup.log'));

line = fgetl(fid);
sample = [];
while ischar(line)

  if (not(isempty(findstr(line, '--------'))))
    samples = [samples, sample'];
  end
  
  if (not(length(line) == 0))
    [sample_label, sample_value] = extract(line);
    samples_labels = unique([sample_label samples_labels]);
    sample_label_index = find(ismember(samples_labels,sample_label));
    sample(sample_label_index) = sample_value;
  end
  
  line = fgetl(fid);
  
end

fclose(fid);

build_plot(samples_labels, samples);
sleep(1000)
