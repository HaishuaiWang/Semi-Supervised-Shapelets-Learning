function Data_z=z_regularization(Data)
D_max=max(max(Data));
D_min=min(min(Data));
Data_z=(Data-D_min)/(D_max-D_min);