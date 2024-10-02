import numpy as np
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

### read dataset

df = pd.read_excel('raw_data/refined_data.xlsx')

print("===== summary =====", df.describe(include = 'all'))



### check variable names

for i in range(0,6):
  print(df.columns[i])

### cosine similarity

def cos_sim(vec1, vec2):

  # vector angular
  dot_product = np.dot(vec1, vec2)

  # vector size(norm)
  norm_vec1 = np.linalg.norm(vec1)
  norm_vec2 = np.linalg.norm(vec2)

  # cosine similarity
  cosine_sim = dot_product / (norm_vec1 * norm_vec2)

  return cosine_sim

