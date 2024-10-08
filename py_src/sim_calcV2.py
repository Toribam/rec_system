import numpy as np
import pandas as pd

class SimCalc:


    def __init__(self, raw_data, col_range):
        self.raw_data = raw_data    # save data as instance
        self.col_range = col_range  # columns to use range from raw_data
    
    ### Cosine similarity
    def cosine_sim(self):

        from sklearn.metrics.pairwise import cosine_similarity
        
        # DataFrame to NumPy array
        data = self.raw_data.iloc[:, 1:].values        # 첫 번째 열 제외, 나머지 열 사용

        # calculation cosine similarity about all items
        cosine_similarity_matrix = cosine_similarity(data)

        # declare a list to save data
        similarity_results = []

        # for loop for cosine similarity
        for i in range(len(cosine_similarity_matrix)):
            for j in range(i + 1, len(cosine_similarity_matrix)):
                similarity_results.append([i + 1, j + 1, cosine_similarity_matrix[i, j]])
        
        # save data as pandas DataFrame
        similarity_df = pd.DataFrame(similarity_results, columns=["Row1", "Row2", "Cosine Similarity"])

        # glimpse data
        print(" ==================== Data Distribution Summary ====================")
        print(similarity_df.describe())
        print("\n")
        print(similarity_df)

        # save data
        similarity_df.to_csv('result/cos_sim.csv', index=False)
        print('"Cosine Similarity" saved as a CSV file.')

    ### Euclidean distance
    def euclidean_dist(self):

        from sklearn.metrics.pairwise import euclidean_distances

        col_name = list(self.raw_data.columns)
        
        euclidean_results = []

        for col_idx in self.col_range:
            # DataFrame to NumPy array
            data_column = self.raw_data.iloc[:, col_idx].values.reshape(-1, 1)

            # calculation euclidean distance about all items
            euclidean_dist_matrix = euclidean_distances(data_column)
            
            # for loop for euclidean distance
            for i in range(len(euclidean_dist_matrix)):
                for j in range(i + 1, len(euclidean_dist_matrix)):
                    euclidean_results.append([i + 1, j + 1, col_name[col_idx], euclidean_dist_matrix[i, j]])
        
        # save result of cosine similarity (i != j)
        euclidean_df = pd.DataFrame(euclidean_results, columns=["Row1", "Row2", "Factor", "Euclidean Distance"])

        # glimpse data
        print(" ==================== Data Distribution Summary ====================")
        print(euclidean_df.describe())
        print("\n")
        print(euclidean_df)

        # save data
        euclidean_df.to_csv('result/euclidean_dist.csv', index=False)
        print('"Euclidean Distance" saved as a CSV file.')


if __name__ == "__main__":

    df = pd.read_excel('raw_data/refined_data.xlsx')

    col_range = range(1, len(list(df.columns)))

    df_cos = SimCalc(df, col_range)