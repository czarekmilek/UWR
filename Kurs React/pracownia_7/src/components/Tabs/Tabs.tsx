import React from 'react';
import * as Tabs from '@radix-ui/react-tabs';
import CustomAvatar from '../Avatar/Avatar';
import CustomCheckbox from '../Checkbox/Checkbox';
import CustomLabel from '../Label/Label';
import CustomLabelSecurity from '../LabelSecurity/LabelSecurity';
import CustomRadioGroup from '../RadioGroup/RadioGroup';
import CustomSelect from '../Select/Select';
import CustomSlider from '../Slider/Slider';
import CustomSwitch from '../Switch/Switch';
import './styles.css';

const CustomTabs: React.FC = () => (
  <Tabs.Root className="TabsRoot" defaultValue="tab1">
    <Tabs.List className="TabsList" aria-label="Manage your account">
      <Tabs.Trigger className="TabsTrigger" value="tab1">
        Account
      </Tabs.Trigger>
      <Tabs.Trigger className="TabsTrigger" value="tab2">
        Password
      </Tabs.Trigger>
      <Tabs.Trigger className="TabsTrigger" value="tab3">
        Preferences
      </Tabs.Trigger>
    </Tabs.List>
    <Tabs.Content className="TabsContent" value="tab1">
      <p className="Text">
        Make changes to your account here. Click save when you're done.
      </p>
      <fieldset className="Fieldset">
        <CustomAvatar />
      </fieldset>
      <fieldset className="Fieldset">
        <CustomLabel></CustomLabel>
      </fieldset>
      <fieldset className="Fieldset">
        <label className="LabelGenderTitle">Gender</label>
        <CustomRadioGroup />
      </fieldset>
      <div
        style={{ display: 'flex', marginTop: 30, justifyContent: 'flex-end' }}
      >
        <button className="Button green">Save</button>
      </div>
    </Tabs.Content>
    <Tabs.Content className="TabsContent" value="tab2">
      <p className="Text">
        Change your password here. After saving, you'll be logged out.
      </p>
      <CustomLabelSecurity></CustomLabelSecurity>
      <div
        style={{ display: 'flex', marginTop: 30, justifyContent: 'flex-end' }}
      >
        <button className="Button green">Save</button>
      </div>
    </Tabs.Content>
    <Tabs.Content className="TabsContent" value="tab3">
      <p className="Text">
        Change preferences here. Click save when you're done.
      </p>
      <fieldset className="Fieldset">
        <label className="Label" htmlFor="collectAdditionalData">
          Collect additional data
        </label>
        <CustomSwitch />
      </fieldset>
      <fieldset className="Fieldset">
        <label className="Label" htmlFor="notificationSettings">
          Notification settings
        </label>
        <CustomSelect />
      </fieldset>
      <fieldset className="Fieldset">
        <label className="Label" htmlFor="notificationFrequency">
          Notification frequency
        </label>
        <CustomSlider />
      </fieldset>
      <fieldset className="Fieldset">
        <CustomCheckbox />
      </fieldset>
      <div
        style={{ display: 'flex', marginTop: 30, justifyContent: 'flex-end' }}
      >
        <button className="Button green">Save</button>
      </div>
    </Tabs.Content>
  </Tabs.Root>
);

export default CustomTabs;
