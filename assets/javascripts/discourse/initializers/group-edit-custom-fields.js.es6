import { withPluginApi } from "discourse/lib/plugin-api";

export default {
  name: "group-edit-custom-fields",
  initialize() {
    withPluginApi("0.8.7", (api) => {
      api.modifyClass("model:group", {
        pluginId: "group-edit-custom-fields",

        asJSON() {

          const json = this._super(...arguments);
          json.custom_fields = this.custom_fields;

          console.log('serializing as json', json)

          return json;
        },
      });
    });
  },
};
