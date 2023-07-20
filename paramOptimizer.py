import pandas as pd
from sklearn.tree import DecisionTreeClassifier
import numpy as np
from sklearn.metrics import roc_auc_score, accuracy_score
from itertools import product


def hyperParameterOptimizer(X_train, X_test, y_train, y_test):
    max_depth_options = range(1, 20, 1)
    min_samples_split_options = range(2, 25, 2)
    min_samples_leaf_options = range(1, 25, 2)
    hyperparameter_options = list(product(max_depth_options, 
                                          min_samples_split_options,
                                          min_samples_leaf_options))
    numConfigurations = len(list(hyperparameter_options))
    print(f"Number of hyperparameter configurations: {numConfigurations}")    
    count = 0
    max_depth_list = np.array([])
    min_samples_split_list = np.array([])
    min_samples_leaf_list = np.array([])
    accuracy_list = np.array([])
    rocAuc_score_list = np.array([])
    # Iterate over the hyperparameter_options
    for hyper_params in hyperparameter_options:
        count += 1
        clf = DecisionTreeClassifier(max_depth=hyper_params[0], min_samples_split=hyper_params[1],
                                     min_samples_leaf=hyper_params[2], class_weight="balanced")
        clf = clf.fit(X_train, y_train)
        y_predicted = clf.predict(X_test)
        # Calculate Metrics
        accuracy = accuracy_score(y_test, y_predicted)
        rocAuc_score = roc_auc_score(y_test, y_predicted)
        # Store variables in their respective lists
        max_depth_list = np.append(max_depth_list, [hyper_params[0]])
        min_samples_split_list = np.append(min_samples_split_list, [hyper_params[1]])
        min_samples_leaf_list = np.append(min_samples_leaf_list, [hyper_params[2]])
        accuracy_list = np.append(accuracy_list, [accuracy])
        rocAuc_score_list = np.append(rocAuc_score_list, [rocAuc_score])
        # Output to show progress of the function
        if count % 100 == 0:
            print(f"Done: {count} out of {numConfigurations}")
    # Create dataframe containing the results
    clf_data = pd.DataFrame({"max_depth": max_depth_list,
                    "min_samples_split": min_samples_split_list,
                    "min_samples_leaf": min_samples_leaf_list,
                    "Accuracy": accuracy_list,
                    "AUC_ROC": rocAuc_score_list
                    })
    return clf_data
