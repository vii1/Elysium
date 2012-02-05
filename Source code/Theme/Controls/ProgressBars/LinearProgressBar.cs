﻿using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Diagnostics.CodeAnalysis;
using System.Diagnostics.Contracts;
using System.Security;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media.Animation;
using System.Windows.Shapes;

using Elysium.Theme.Controls.Primitives;
using Elysium.Theme.Extensions;

using JetBrains.Annotations;

namespace Elysium.Theme.Controls
{
    [PublicAPI]
    [TemplatePart(Name = IndicatorName, Type = typeof(Rectangle))]
    [TemplatePart(Name = BusyBarName, Type = typeof(Canvas))]
    public class LinearProgressBar : ProgressBarBase
    {
        private const string IndicatorName = "PART_Indicator";
        private const string BusyBarName = "PART_BusyBar";

        private Rectangle _indicator;
        private Canvas _busyBar;

        [SuppressMessage("Microsoft.Performance", "CA1810:InitializeReferenceTypeStaticFieldsInline")]
        static LinearProgressBar()
        {
            DefaultStyleKeyProperty.OverrideMetadata(typeof(LinearProgressBar), new FrameworkPropertyMetadata(typeof(LinearProgressBar)));
        }

        [PublicAPI]
        public static readonly DependencyProperty OrientationProperty =
            DependencyProperty.Register("Orientation", typeof(Orientation), typeof(ProgressBarBase),
                                        new FrameworkPropertyMetadata(Orientation.Horizontal, FrameworkPropertyMetadataOptions.AffectsMeasure),
                                        IsValidOrientation);

        [PublicAPI]
        [Category("Appearance")]
        [Description("Determines orientation of control.")]
        public Orientation Orientation
        {
            get { return BoxingHelper<Orientation>.Unbox(GetValue(OrientationProperty)); }
            set { SetValue(OrientationProperty, value); }
        }

        private static bool IsValidOrientation(object value)
        {
            var orientation = BoxingHelper<Orientation>.Unbox(value);
            return orientation == Orientation.Horizontal || orientation == Orientation.Vertical;
        }

        [SecuritySafeCritical]
        internal override void OnApplyTemplateInternal()
        {
            if (Template != null)
            {
                _indicator = Template.FindName(IndicatorName, this) as Rectangle;
                // NOTE: WPF doesn't declare contracts
                Contract.Assume(Template != null);
                _busyBar = Template.FindName(BusyBarName, this) as Canvas;
            }

            base.OnApplyTemplateInternal();
        }

        protected override void OnAnimationsUpdating(RoutedEventArgs e)
        {
            base.OnAnimationsUpdating(e);

            UpdateIndeterminateAnimation();

            UpdateBusyAnimation();
        }

        private void UpdateIndeterminateAnimation()
        {
            if (IndeterminateAnimation != null && IndeterminateAnimation.Name == DefaultIndeterminateAnimationName && Track != null && _indicator != null)
            {
                var isStarted = State == ProgressBarState.Indeterminate && IsEnabled;
                if (isStarted)
                {
                    IndeterminateAnimation.Stop(this);
                    IndeterminateAnimation.Remove(this);
                }

                IndeterminateAnimation = new Storyboard { Name = DefaultIndeterminateAnimationName, RepeatBehavior = RepeatBehavior.Forever };

                var indicatorSize = Orientation == Orientation.Horizontal ? _indicator.Width : _indicator.Height;

                var trackSize = Orientation == Orientation.Horizontal ? Track.ActualWidth : Track.ActualHeight;

                var time = trackSize / 100;

                var animation = new DoubleAnimationUsingKeyFrames { Duration = new Duration(TimeSpan.FromSeconds(time + 0.5)) };
                // NOTE: WPF doesn't declare contracts
                Contract.Assume(animation.KeyFrames != null);
                animation.KeyFrames.Add(new DiscreteDoubleKeyFrame(-indicatorSize - 1, KeyTime.FromTimeSpan(TimeSpan.FromSeconds(0))));
                animation.KeyFrames.Add(new LinearDoubleKeyFrame(trackSize + 1, KeyTime.FromTimeSpan(TimeSpan.FromSeconds(time))));

                Storyboard.SetTarget(animation, _indicator);
                Storyboard.SetTargetProperty(animation,
                                             new PropertyPath(Orientation == Orientation.Horizontal ? Canvas.LeftProperty : Canvas.TopProperty));

                // Bug in Code Contracts
                Contract.Assume(IndeterminateAnimation != null);
                Contract.Assume(IndeterminateAnimation.Children != null);

                IndeterminateAnimation.Children.Add(animation);

                if (isStarted)
                {
                    IndeterminateAnimation.Begin(this, Template, true);
                }
            }
        }

        private void UpdateBusyAnimation()
        {
            if (BusyAnimation != null && BusyAnimation.Name == DefaultBusyAnimationName && Track != null && _busyBar != null)
            {
                var isStarted = State == ProgressBarState.Busy && IsEnabled;
                if (isStarted)
                {
                    BusyAnimation.Stop(this);
                    BusyAnimation.Remove(this);
                }

                // NOTE: WPF doesn't declare contracts
                Contract.Assume(_busyBar.Children != null);

                BusyAnimation = new Storyboard { Name = DefaultBusyAnimationName, RepeatBehavior = RepeatBehavior.Forever };

                const double time = 0.25;
                const double durationTime = time * 2;
                const double beginTimeIncrement = time / 2;
                const double shortPauseTime = time;
                const double longPauseTime = time * 1.5;
                var partMotionTime = (_busyBar.Children.Count - 1) * beginTimeIncrement + durationTime;

                var busyAnimations = new Collection<DoubleAnimation>();

                var width = Track.ActualWidth;
                var height = Track.ActualHeight;

                for (var i = 0; i < _busyBar.Children.Count; i++)
                {
                    var element = (FrameworkElement)_busyBar.Children[_busyBar.Children.Count - i - 1];

                    if (element != null)
                    {
                        var elementWidth = element.Width;
                        var elementHeight = element.Height;

                        var index = (_busyBar.Children.Count - 1) / 2 - i;

                        var center = (Orientation == Orientation.Horizontal ? width : height) / 2;
                        var margin = Orientation == Orientation.Horizontal ? elementWidth : elementHeight;

                        var startPosition = -(Orientation == Orientation.Horizontal ? elementWidth : elementHeight) - 1;
                        var endPosition = center + index * ((Orientation == Orientation.Horizontal ? elementWidth : elementHeight) + margin);

                        var duration = new Duration(TimeSpan.FromSeconds(durationTime));
                        var animation = new DoubleAnimation(startPosition, endPosition, duration) { BeginTime = TimeSpan.FromSeconds(i * beginTimeIncrement) };
                        Storyboard.SetTarget(animation, element);
                        Storyboard.SetTargetProperty(animation,
                                                     new PropertyPath(Orientation == Orientation.Horizontal ? Canvas.LeftProperty : Canvas.TopProperty));

                        busyAnimations.Add(animation);
                    }
                }

                for (var i = 0; i < _busyBar.Children.Count; i++)
                {
                    var element = (FrameworkElement)_busyBar.Children[_busyBar.Children.Count - i - 1];


                    if (element != null)
                    {
                        var elementWidth = element.Width;
                        var elementHeight = element.Height;

                        var endPosition = (Orientation == Orientation.Horizontal ? width : height) +
                                          (Orientation == Orientation.Horizontal ? elementWidth : elementHeight) + 1;

                        var duration = new Duration(TimeSpan.FromSeconds(durationTime));
                        var animation = new DoubleAnimation(endPosition, duration) { BeginTime = TimeSpan.FromSeconds(partMotionTime + shortPauseTime + i * beginTimeIncrement) };
                        Storyboard.SetTarget(animation, element);
                        Storyboard.SetTargetProperty(animation,
                                                     new PropertyPath(Orientation == Orientation.Horizontal ? Canvas.LeftProperty : Canvas.TopProperty));

                        busyAnimations.Add(animation);
                    }
                }

                BusyAnimation.Duration = new Duration(TimeSpan.FromSeconds(partMotionTime * 2 + shortPauseTime + longPauseTime));

                // NOTE: WPF doesn't declare contracts
                Contract.Assume(BusyAnimation.Children != null);
                foreach (var animation in busyAnimations)
                {
                    BusyAnimation.Children.Add(animation);
                }

                if (isStarted)
                {
                    BusyAnimation.Begin(this, Template, true);
                }
            }
        }
    }
} ;