

def hello_world():
    return 'hello world'


class FilterModule(object):
    def filters(self):
        return {'hello_world': hello_world}
