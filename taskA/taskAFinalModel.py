import pandas as pd
from sklearn.tree import DecisionTreeClassifier
from sklearn.utils import shuffle
from sklearn.metrics import confusion_matrix, plot_confusion_matrix, accuracy_score, roc_auc_score
from sklearn.model_selection import train_test_split
from sklearn import tree
import matplotlib.pyplot as plt

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
                    'FI_GS', 'FI_InnOuts', 'FI_A', 'FI_E', 'FI_DP',
                    'ASF_NUM_YEARS', 'MAX_SAL', 'MAX_SAL_YEAR', 'A_YP', 'A_G_ALL', 'A_GP']


    df_X = df[train_features]
    df_y = df['nominated']
    X_train, X_test, y_train, y_test = train_test_split(df_X, df_y, test_size=0.2, random_state=42)
    
    # Create Model, make predictions and calculate metrics
    clf = DecisionTreeClassifier(max_depth=6, min_samples_split=14, min_samples_leaf=15, class_weight="balanced")
    clf = clf.fit(X_train, y_train)

    y_predicted = clf.predict(X_test)
    rocAuc_score = roc_auc_score(y_test, y_predicted)
    accuracy = accuracy_score(y_test, y_predicted)
    conf_matrix = confusion_matrix(y_test, y_predicted)

    # Output Results
    print(f"y_train Value Counts:\n{y_train.value_counts()}")
    print(f"Accuracy = {accuracy}")
    print(f"ROC AUC Score: {rocAuc_score}")
    confMatrix = pd.DataFrame(conf_matrix, columns =['False', 'True'], index = ["False", "True"]) 
    print(f"Confusion Matrix: \n {confMatrix}")
    plot_confusion_matrix(clf, X_test, y_test)
    plt.savefig('../pngs/taskA_finalModel_confMatrix.png')
    
    tree.export_graphviz(clf, out_file='taskAFinalModel.dot', 
                                feature_names=X_train.columns,
                                class_names=["Not Nominated", "Nominated"],
                                filled=True)