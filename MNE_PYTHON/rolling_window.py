def rolling_window(a, size):

	shape = a.shape[:-1] + (a.shape[-1] - size + 1, size)
	strides = a.strides + (a. strides[-1],)
	return numpy.lib.stride_tricks.as_strided(a, shape=shape, strides=strides)
