import sys
 
# setting path
sys.path.append('..')
 
# importing
from paramOptimizer import hyperParameterOptimizer
import pandas as pd
from sklearn.utils import shuffle
from sklearn import tree
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt
from sklearn.utils import shuffle


if __name__ == "__main__":
    # Read CSV file that our SQL Query Generated as a pandas DataFrame
    df = pd.read_csv("../CSV/A-1.csv")
    # Adding 'nominated' column to the dataFrame
    df['nominated'] = df.apply(lambda row: True if row['inducted'] in ['Y', 'N'] else False, axis=1)
    # Shuffling Data
    df = shuffle(df, random_state=42)
    # Filling the 'NaN' values with 0
    df = df.fillna(0)
    # Create train and test data
    train_features = ['B_AB', 'B_R', 'B_H', 'B_HR', 'B_RBI', 'B_SB', 'B_SO',
                    'PI_W', 'PI_L', 'PI_CG', 'PI_SV', 'PI_H', 
                    'PI_HR', 'PI_BB', 'PI_SO', 'PI_AVG_ERA', 'PI_R',
                    'FI_G', 'FI_GS', 'FI_InnOuts', 'FI_A', 'FI_E', 'FI_DP',
                    'ASF_NUM_YEARS', 'MAX_SAL', 'MAX_SAL_YEAR', 'A_YP', 'A_G_ALL', 'A_GP']
    
    df_X = df[train_features]
    df_y = df['nominated']
    X_train, X_test, y_train, y_test = train_test_split(df_X, df_y, test_size=0.2, random_state=42)
    clf_data = hyperParameterOptimizer(X_train, X_test, y_train, y_test)
    clf_data.to_csv("../CSV/taskAParamOptimizerResults.csv")
    
    # Create plot of AUC_ROC vs max depth for each combination of min_samples_split and min_samples_leaf
    min_samples_split_range = range(2, 25, 2)
    min_samples_leaf_range = range(1, 25, 2)
    for min_samples_split in min_samples_split_range:
        for min_samples_leaf in min_samples_leaf_range:
            data = clf_data.loc[(clf_data["min_samples_split"] == min_samples_split) & (clf_data["min_samples_leaf"] == min_samples_leaf)]
            plt.plot(data["max_depth"], data["AUC_ROC"], label=f"split = {min_samples_split}, leaf = {min_samples_leaf}")

    plt.xlabel("max_depth")
    plt.ylabel("AUC ROC score")
    plt.savefig('taskA_paramOptimizerePlot.png')