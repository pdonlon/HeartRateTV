import cherrypy
import json
import math
import time

class HeartRateServer(object):
    users = {
        "Philip": {'wave_func': math.sin, 'speed_div': 1, 'base_bpm': 60, 'wave_height': 201, 'age':30},
        "Richard": {'wave_func': math.cos, 'speed_div': 1, 'base_bpm': 75, 'wave_height': 151, 'age':26},
        "Jason": {'wave_func': math.tan, 'speed_div': 2, 'base_bpm': 70, 'wave_height': 101, 'age':21},
    }
  
    @cherrypy.expose
    @cherrypy.tools.json_out()
    def index(self):
        data = []
        for user_name, user_settings in self.users.items():
            time_speed_adjusted = time.time() / user_settings['speed_div']
            bpm = user_settings['base_bpm'] + user_settings['wave_func'](time_speed_adjusted) * user_settings['wave_height']

            # Keep the generated heart rate between acceptable limits
            #bpm = max(50, min(bpm, 200))
            
            data.append({
                "title": user_name,
                "thumbnail": "https://gravatar.com/avatar/"+user_name+"?s=200&d=identicon",
                "bpm": int(bpm),
                "age": user_settings['age']
            })
        return data

if __name__ == '__main__':
    cherrypy.server.socket_host = '0.0.0.0'
    cherrypy.quickstart(HeartRateServer(), '/', None)
