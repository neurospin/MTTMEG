def load_object(filename):
    import pickle
    with open(filename, 'rb') as output:
        obj = pickle.load(output)
	return obj
