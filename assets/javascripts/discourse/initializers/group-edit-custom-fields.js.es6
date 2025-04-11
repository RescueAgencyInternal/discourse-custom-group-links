// assets/javascripts/discourse/initializers/group-edit-custom-fields.js.es6
import { withPluginApi } from "discourse/lib/plugin-api";

export default {
  name: "group-edit-custom-fields",
  initialize() {
    withPluginApi("0.8.7", api => {
      api.modifyClass('model:group', {
        pluginId: 'group-edit-custom-fields',
        custom_fields: {},
        asJSON() {
          return Object.assign(this._super(), {
            custom_fields: this.custom_fields
          });
        }
      });
    });
  }
};
